return {
  cmd = { "jdtls", "-configuration", "/home/runner/.cache/jdtls/config", "-data", "/home/runner/.cache/jdtls/workspace" },
  filetypes = { "java" },
  handlers = {
    -- ["language/status"] = <function 1>,
    -- ["textDocument/codeAction"] = <function 2>,
    -- ["textDocument/rename"] = <function 3>,
    -- ["workspace/applyEdit"] = <function 4>
  },
  init_options = {
    jvm_args = {},
    workspace = "/home/runner/.cache/jdtls/workspace"
  },
  root_markers = { ".git", "build.gradle", "build.gradle.kts", "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" }
}
