"""Reachability regressions: dynamic callbacks, public aliases and dead cycles."""
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


class FunctionAuditTest(unittest.TestCase):
    def test_dynamic_calls_and_disconnected_cycle(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            tools = root / 'pack/tools'
            functions = root / 'pack/data/oa/function'
            tools.mkdir(parents=True)
            shutil.copyfile(Path(__file__).with_name('audit_unused.py'), tools / 'audit_unused.py')
            (tools / 'function_roots.json').write_text(json.dumps({'oa:compat/old': 'saved public alias'}))
            bodies = {
                'load': 'function oa:dispatch\n',
                'dispatch': '$function oa:steps/$(n)\n',
                'steps/1': 'return 1\n',
                'native/action': 'return 1\n',
                'compat/old': 'function oa:compat/internal\n',
                'compat/internal': 'return 1\n',
                'unused/a': 'function oa:unused/b\n',
                'unused/b': 'function oa:unused/a\n',
            }
            for name, body in bodies.items():
                path = functions / (name + '.mcfunction')
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(body)
            java = root / 'external-plugin/src/Callback.java'
            java.parent.mkdir(parents=True)
            java.write_text('class Callback { String action = "native/" + selected; }')
            report = root / 'report.json'
            command = [sys.executable, str(tools / 'audit_unused.py'), '--plugin', str(java.parent.parent), '--report', str(report)]
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 1, result.stderr)
            self.assertEqual(json.loads(report.read_text())['candidates'], ['oa:unused/a', 'oa:unused/b'])
            for name in ['unused/a', 'unused/b']:
                (functions / (name + '.mcfunction')).unlink()
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(json.loads(report.read_text())['reachable'], 6)
            empty = functions / 'steps/2.mcfunction'
            empty.write_text('# Retired callback with no commands\n')
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 1)
            self.assertEqual(json.loads(report.read_text())['candidates'], ['oa:steps/2'])
            empty.unlink()
            (functions / 'compat/old.mcfunction').unlink()
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('Missing public/compatibility function', result.stderr)


if __name__ == '__main__':
    unittest.main()
