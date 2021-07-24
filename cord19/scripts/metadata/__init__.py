import os

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))

RDF_DIR = os.path.join(ROOT_DIR, 'rdf/metadata')
DATA_DIR = os.path.join(ROOT_DIR, 'data')
METADATA_DIR = os.path.join(DATA_DIR, 'metadata')
CONTEXT_DIR = os.path.join(ROOT_DIR, 'contexts')
SOURCE_DIR = os.path.join(ROOT_DIR, 'source')
