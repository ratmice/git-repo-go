#!/bin/sh

test_description="git-repo init"

. ./lib/sharness.sh

manifest_url="file://${REPO_TEST_REPOSITORIES}/hello/manifests"
main_repo_url="file://${REPO_TEST_REPOSITORIES}/hello/manifests"
wrong_url="file://${REPO_TEST_REPOSITORIES}/hello/bad"

test_expect_success "setup" '
	# create .repo file as a barrier, not find .repo deeper
	touch .repo &&
	mkdir work
'

test_expect_success "init from wrong url" '
	(
		cd work &&
		test_must_fail git-repo init -u $wrong_url &&
		test ! -d .repo/manifests.git
	)
'

test_expect_success "init from main url without a valid xml" '
	(
		cd work &&
		test_must_fail git-repo init -u $main_repo_url
	)
'

test_done