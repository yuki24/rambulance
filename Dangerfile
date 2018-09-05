# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "WIP"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Don't let testing shortcuts get into master by accident
fail("fdescribe left in tests") if `grep -r fdescribe test/ `.length > 1
fail("fit left in tests") if `grep -r fit test/ `.length > 1

# Most spellcheckers think my name has a typo
prose.ignored_words = ["yuki"]

# Runs a linter with all styles, on modified and added markdown files in this PR
prose.check_spelling
