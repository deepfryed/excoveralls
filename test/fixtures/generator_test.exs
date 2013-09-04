defmodule ExCoveralls.GeneratorTest do
  use ExUnit.Case
  import Mock
  alias ExCoveralls.Generator
  alias ExCoveralls.Utils

  @content     "defmodule Test do\n  def test do\n  end\nend\n"
  @counts      [0, 1, nil, nil]
  @source      "test/fixtures/test.ex"
  @source_info [[name: "test/fixtures/test.ex",
                 source: @content,
                 coverage: @counts
               ]]

  test_with_mock "generate json", Utils, [getenv: fn("EXCOVERALLS_SERVICE_NAME",_) -> "local" end,
                                          getenv: fn("COVERALLS_REPO_TOKEN") -> "1234567890" end] do
    assert(Generator.execute(@source_info, "general") ==
       "{\"repo_token\":\"1234567890\"," <>
         "\"service_name\":\"local\"," <>
         "\"source_files\":" <>
           "[{\"name\":\"test\\/fixtures\\/test.ex\"," <>
             "\"source\":\"defmodule Test do\\n  def test do\\n  end\\nend\\n\"," <>
             "\"coverage\":[0,1,null,null]}]}")
  end
end

