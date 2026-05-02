#!/usr/bin/env python3
"""
Remove comments from GDScript (.gd) and shader (.gdshader) files.
For GDScript: lines starting with # (excluding shebang) are removed.
For shaders: // and /* */ comments are removed.
"""

import os
import re
import sys

def remove_gd_comments(content):
    """Remove # comments from GDScript, preserving shebang if present."""
    lines = content.splitlines()
    out_lines = []
    for line in lines:
        stripped = line.lstrip()
        if stripped.startswith('#'):
            # Skip comment line entirely
            continue
        # Keep line as is (may contain inline comments? GDScript doesn't have inline)
        out_lines.append(line)
    return '\n'.join(out_lines)

def remove_shader_comments(content):
    """Remove // and /* */ comments from shader code."""
    # Remove block comments first
    def _remove_block(match):
        # Replace with empty string unless it contains newline, then keep newline count
        s = match.group(0)
        # Count newlines to preserve line numbers roughly
        newline_count = s.count('\n')
        return '\n' * newline_count
    
    # Remove /* ... */ across lines
    pattern = r'/\*.*?\*/'
    content = re.sub(pattern, _remove_block, content, flags=re.DOTALL)
    
    # Remove // comments
    lines = content.splitlines()
    out_lines = []
    for line in lines:
        # Find // not inside string? simple approach: remove from first // onward
        idx = line.find('//')
        if idx != -1:
            line = line[:idx]
        # If line becomes empty after stripping, skip it
        if line.strip() == '':
            continue
        out_lines.append(line)
    return '\n'.join(out_lines)

def process_file(filepath):
    """Process a single file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if filepath.endswith('.gd'):
        new_content = remove_gd_comments(content)
    elif filepath.endswith('.gdshader'):
        new_content = remove_shader_comments(content)
    else:
        print(f"Skipping {filepath} (unsupported extension)")
        return
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")
    else:
        print(f"No changes {filepath}")

def main():
    # Define directories relative to script location
    base_dir = os.path.dirname(os.path.abspath(__file__))
    autoload_dir = os.path.join(base_dir, 'GAME', 'game-files', 'autoload')
    script_dir = os.path.join(base_dir, 'GAME', 'game-files', 'script')
    
    for root, dirs, files in os.walk(autoload_dir):
        for f in files:
            if f.endswith('.gd') or f.endswith('.gdshader'):
                process_file(os.path.join(root, f))
    
    for root, dirs, files in os.walk(script_dir):
        for f in files:
            if f.endswith('.gd') or f.endswith('.gdshader'):
                process_file(os.path.join(root, f))
    
    print("Done.")

if __name__ == '__main__':
    main()