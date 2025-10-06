"""
Vercel Serverless Function wrapper for FastAPI
This file adapts the FastAPI app to work with Vercel's serverless functions
"""

import sys
import os

# Add backend directory to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'backend'))

from main import app

# Export the FastAPI app for Vercel
handler = app

