.PHONY: install generate ingest dbt-run dbt-test graph vector analytics pipeline serve test lint format clean

install:
	uv venv --python 3.12
	uv pip install -e ".[dev]"

# Run the full lakehouse pipeline end-to-end.
pipeline:
	uv run python -m claims.pipeline

generate:
	uv run python -m claims.generator

ingest:
	uv run python -m claims.ingest

dbt-run:
	cd dbt && uv run dbt run

dbt-test:
	cd dbt && uv run dbt test

graph:
	uv run python -m claims.graph

vector:
	uv run python -m claims.vector_search

analytics:
	uv run python -m claims.analytics

serve:
	uv run uvicorn claims.api.main:app --host 0.0.0.0 --port 8000 --reload

test:
	uv run pytest

lint:
	uv run ruff check .

format:
	uv run ruff format .

clean:
	rm -rf data/raw/* warehouse/*.duckdb warehouse/*.wal models/*.pkl models/*.graphml \
	       dbt/target dbt/logs reports/figures .pytest_cache .ruff_cache
