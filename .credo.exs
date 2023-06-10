%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/"],
        excluded: []
      },
      plugins: [],
      requires: [],
      strict: true,
      parse_timeout: 5000,
      color: true,
      checks: [
        {Credo.Check.Warning.IoInspect, false},
        {Credo.Check.Readability.ModuleDoc, false}
      ]
    }
  ]
}
