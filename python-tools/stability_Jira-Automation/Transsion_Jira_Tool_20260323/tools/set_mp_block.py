import jira_block_common as common


JIRA_SERVER = common.JIRA_SERVER
TARGET_FIELD_NAME = common.TARGET_FIELD_NAME
TARGET_FIELD_VALUE = "MP Block"

build_jql = common.build_jql
_format_project_clause = common._format_project_clause
_format_reporter_clause = common._format_reporter_clause
get_jira_credentials = common.get_jira_credentials
connect_to_jira = common.connect_to_jira
resolve_field_id = common.resolve_field_id
get_field_meta_from_editmeta = common.get_field_meta_from_editmeta
build_field_value = common.build_field_value
set_block_labels = common.set_block_labels


def find_reporter_issues(*args, **kwargs):
    return common.search_matching_issues(*args, **kwargs)


def find_all_reporter_issues(client, jql, field_id=None, **kwargs):
    return common.search_matching_issues(client, jql, field_id=field_id)


def set_mp_block_for_one_issue(client, project_key, reporter, **kwargs):
    return common.set_block_labels(
        client, TARGET_FIELD_VALUE, project_key, reporter, **kwargs
    )


def parse_args():
    return common.parse_block_args("设置当前用户提单的必解标签为 MP Block")


def main():
    common.run_block_tool(TARGET_FIELD_VALUE)


if __name__ == "__main__":
    main()
