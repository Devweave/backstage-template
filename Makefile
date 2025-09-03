# Backstage Templates Makefile
# This Makefile automates template discovery and catalog generation

.PHONY: help discover-templates generate-catalog validate-templates validate-yaml clean install dev-setup check-tools

# Default target
help: ## Show this help message
	@echo "Backstage Templates Management"
	@echo "=============================="
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

# Variables
CATALOG_FILE := catalog-info.yaml
TEMPLATE_FILES := $(shell find . -type f -name "*template.yaml" -not -path "./.git/*")
GITHUB_BASE_URL := https://github.com/Devweave/backstage-template/blob/master
TEMP_FILE := /tmp/catalog-info-temp.yaml

# Tools check
check-tools: ## Check if required tools are available
	@echo "🔍 Checking required tools..."
	@command -v find >/dev/null 2>&1 || { echo "❌ find is required but not installed."; exit 1; }
	@command -v awk >/dev/null 2>&1 || { echo "❌ awk is required but not installed."; exit 1; }
	@command -v sort >/dev/null 2>&1 || { echo "❌ sort is required but not installed."; exit 1; }
	@echo "✅ All required tools are available"

# Install development dependencies
dev-setup: check-tools ## Set up development environment
	@echo "🔧 Setting up development environment..."
	@if command -v python3 >/dev/null 2>&1; then \
		echo "✅ Python3 is available for optional YAML validation"; \
	else \
		echo "⚠️  Python3 not available - YAML validation will be skipped"; \
	fi
	@echo "✅ Development environment ready"

# Discover all templates
discover-templates: check-tools ## Discover all template.yaml files in the repository
	@echo "🔍 Discovering Backstage templates..."
	@if [ -z "$(TEMPLATE_FILES)" ]; then \
		echo "❌ No template.yaml files found!"; \
		exit 1; \
	fi
	@for template in $(TEMPLATE_FILES); do \
		template_path=$$(echo "$$template" | sed 's|^\./||'); \
		echo "✅ Found template: $$template_path"; \
	done
	@echo "📝 Discovered $(words $(TEMPLATE_FILES)) template(s)"

# Generate catalog-info.yaml
generate-catalog: discover-templates ## Generate catalog-info.yaml with all discovered templates
	@echo "📝 Generating catalog-info.yaml..."
	@echo "apiVersion: backstage.io/v1alpha1" > $(TEMP_FILE)
	@echo "kind: Location" >> $(TEMP_FILE)
	@echo "metadata:" >> $(TEMP_FILE)
	@echo "  name: devweave-templates" >> $(TEMP_FILE)
	@echo "  description: Devweave Software Templates Repository - Auto-generated template discovery" >> $(TEMP_FILE)
	@echo "  annotations:" >> $(TEMP_FILE)
	@echo "    backstage.io/managed-by-location: url:$(GITHUB_BASE_URL)/catalog-info.yaml" >> $(TEMP_FILE)
	@echo "    backstage.io/generated-by: makefile" >> $(TEMP_FILE)
	@echo "    backstage.io/generated-at: $$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> $(TEMP_FILE)
	@echo "  tags:" >> $(TEMP_FILE)
	@echo "  - templates" >> $(TEMP_FILE)
	@echo "  - scaffolder" >> $(TEMP_FILE)
	@echo "  - devweave" >> $(TEMP_FILE)
	@echo "spec:" >> $(TEMP_FILE)
	@echo "  type: url" >> $(TEMP_FILE)
	@echo "  targets:" >> $(TEMP_FILE)
	@for template in $(TEMPLATE_FILES); do \
		template_path=$$(echo "$$template" | sed 's|^\./||'); \
		echo "  - $(GITHUB_BASE_URL)/$$template_path" >> $(TEMP_FILE); \
	done
	@mv $(TEMP_FILE) $(CATALOG_FILE)
	@echo "✅ Generated $(CATALOG_FILE) with $(words $(TEMPLATE_FILES)) template(s)"
	@echo ""
	@echo "📋 Template URLs registered:"
	@for template in $(TEMPLATE_FILES); do \
		template_path=$$(echo "$$template" | sed 's|^\./||'); \
		echo "   - $(GITHUB_BASE_URL)/$$template_path"; \
	done

# Validate templates (basic syntax check without Python)
validate-templates: discover-templates ## Validate all template.yaml files for basic syntax
	@echo "🔍 Validating template YAML files..."
	@for template in $(TEMPLATE_FILES); do \
		echo "Checking $$template..."; \
		if head -1 "$$template" | grep -q "apiVersion:"; then \
			if grep -q "kind: Template" "$$template"; then \
				if grep -q "metadata:" "$$template" && grep -q "spec:" "$$template"; then \
					echo "✅ $$template has basic YAML structure"; \
				else \
					echo "❌ $$template missing required metadata or spec sections"; \
					exit 1; \
				fi; \
			else \
				echo "❌ $$template missing 'kind: Template'"; \
				exit 1; \
			fi; \
		else \
			echo "❌ $$template missing 'apiVersion'"; \
			exit 1; \
		fi; \
	done
	@echo "✅ All templates passed basic validation"

# Advanced YAML validation (if Python is available)
validate-yaml: discover-templates ## Advanced YAML syntax validation using Python
	@echo "🔍 Running advanced YAML validation..."
	@if command -v python3 >/dev/null 2>&1; then \
		for template in $(TEMPLATE_FILES); do \
			echo "Validating $$template..."; \
			python3 -c "import yaml; yaml.safe_load(open('$$template'))" && echo "✅ $$template is valid" || { echo "❌ $$template has syntax errors"; exit 1; }; \
		done; \
		echo "✅ All templates passed advanced YAML validation"; \
	else \
		echo "❌ Python3 not available for advanced validation"; \
		echo "� Run 'make validate-templates' for basic validation"; \
		exit 1; \
	fi

# Show current template status
status: ## Show current template discovery status
	@echo "📊 Template Repository Status"
	@echo "============================="
	@echo "Templates found: $(words $(TEMPLATE_FILES))"
	@echo "Catalog file: $(CATALOG_FILE)"
	@echo "Last modified: $$(if [ -f $(CATALOG_FILE) ]; then stat -c %y $(CATALOG_FILE); else echo 'Not generated'; fi)"
	@echo ""
	@echo "📁 Template files:"
	@for template in $(TEMPLATE_FILES); do \
		echo "   - $$template"; \
	done

# Clean generated files
clean: ## Clean generated catalog files
	@echo "🧹 Cleaning generated files..."
	@rm -f $(TEMP_FILE)
	@echo "✅ Cleanup complete"

# All-in-one: validate, generate, and show status
all: validate-templates generate-catalog status ## Run full template processing pipeline

# Quick setup for new repositories
init: dev-setup generate-catalog ## Initialize template repository with catalog generation
	@echo ""
	@echo "🎉 Template repository initialized!"
	@echo ""
	@echo "📖 Next steps:"
	@echo "   1. Review the generated $(CATALOG_FILE)"
	@echo "   2. Commit and push your changes"
	@echo "   3. Add this to your Backstage app-config.yaml:"
	@echo ""
	@echo "   catalog:"
	@echo "     locations:"
	@echo "       - type: url"
	@echo "         target: $(GITHUB_BASE_URL)/catalog-info.yaml"
	@echo "         rules:"
	@echo "           - allow: [Location, Template]"

# Watch for changes (if inotify-tools is available)
watch: ## Watch for template changes and auto-regenerate catalog
	@if command -v inotifywait >/dev/null 2>&1; then \
		echo "👀 Watching for template changes..."; \
		echo "Press Ctrl+C to stop"; \
		while inotifywait -e modify,create,delete -r . --include='template\.yaml$$' 2>/dev/null; do \
			echo "🔄 Template change detected, regenerating catalog..."; \
			make generate-catalog; \
		done; \
	else \
		echo "❌ inotifywait not available. Install inotify-tools to use watch mode."; \
		echo "💡 You can manually run 'make generate-catalog' when templates change."; \
	fi

# Check if catalog is up to date
check: discover-templates ## Check if catalog-info.yaml is up to date
	@echo "🔍 Checking if catalog is up to date..."
	@make generate-catalog > /dev/null 2>&1
	@if diff -q $(CATALOG_FILE) $(TEMP_FILE) > /dev/null 2>&1; then \
		echo "✅ Catalog is up to date"; \
		rm -f $(TEMP_FILE); \
	else \
		echo "❌ Catalog is out of date"; \
		echo "💡 Run 'make generate-catalog' to update"; \
		rm -f $(TEMP_FILE); \
		exit 1; \
	fi

# Generate and show diff
diff: discover-templates ## Show what would change in catalog-info.yaml
	@echo "📋 Catalog differences:"
	@make generate-catalog > /dev/null 2>&1
	@if [ -f $(CATALOG_FILE) ]; then \
		diff -u $(CATALOG_FILE) $(TEMP_FILE) || true; \
	else \
		echo "New file would be created:"; \
		cat $(TEMP_FILE); \
	fi
	@rm -f $(TEMP_FILE)
