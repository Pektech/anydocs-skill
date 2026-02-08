#!/bin/bash
# Setup script for anydocs

set -e

echo "================================"
echo "anydocs Setup"
echo "================================"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "✗ Python 3 is required but not installed"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | awk '{print $2}')
echo "✓ Python 3 found: $PYTHON_VERSION"

# Check pip
if ! command -v pip3 &> /dev/null; then
    echo "✗ pip3 is required but not installed"
    exit 1
fi

echo "✓ pip3 found"
echo ""

# Install dependencies
echo "Installing dependencies..."
pip3 install --break-system-packages -r requirements.txt > /dev/null 2>&1
echo "✓ Dependencies installed"
echo ""

# Run tests
echo "Running tests..."
python3 test_anydocs.py
echo ""

# Make executable
chmod +x anydocs.py
echo "✓ anydocs.py is executable"

# Setup symlink (optional)
if [ "$1" == "--system" ]; then
    echo ""
    echo "Installing system-wide..."
    sudo ln -sf "$(pwd)/anydocs.py" /usr/local/bin/anydocs
    echo "✓ anydocs available as 'anydocs' command"
fi

echo ""
echo "================================"
echo "Setup Complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "  1. Configure a documentation site:"
echo "     python3 anydocs.py config discord https://discord.com/developers/docs https://discord.com/developers/docs/sitemap.xml"
echo ""
echo "  2. Build the index:"
echo "     python3 anydocs.py index discord"
echo ""
echo "  3. Search!"
echo "     python3 anydocs.py search 'webhooks' --profile discord"
echo ""
echo "For more examples, see: examples/QUICKSTART.md"
echo ""
