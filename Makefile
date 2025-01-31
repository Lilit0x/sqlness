SHELL = /bin/bash

DIR=$(shell pwd)

init:
	echo "init"
	echo "Git branch: $GITBRANCH"

test:
	cd $(DIR); cargo test --workspace -- --test-threads=4

fmt:
	cd $(DIR); cargo fmt -- --check

check-cargo-toml:
	cd $(DIR); cargo sort --workspace --check

check-license:
	cd $(DIR); sh scripts/check-license.sh

clippy:
	cd $(DIR); cargo clippy --all-targets --all-features --workspace -- -D warnings

cli-test:
	cd $(DIR)/sqlness-cli;  cargo run -- -c tests -i 127.0.0.1 -p 3306 -u root -P 1a2b3c -d public

example: good-example bad-example

good-example: basic-example interceptor-arg-example interceptor-replace-example interceptor-sort-result-example

basic-example:
	cd $(DIR)/sqlness; cargo run --example basic

bad-example:
	cd $(DIR)/sqlness; cargo run --example bad

interceptor-arg-example:
	cd $(DIR)/sqlness; cargo run --example interceptor_arg

interceptor-replace-example:
	cd $(DIR)/sqlness; cargo run --example interceptor_replace

interceptor-sort-result-example:
	cd $(DIR)/sqlness; cargo run --example interceptor_sort_result
