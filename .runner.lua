-- Example project config
return {
  c = {
    build = "clang -O2 -Wall '%f' -o '%b'",
    run = "'./%b' %a",
  },
  python = {
    run = "python3 -m mymodule %a",
    test = "python3 -m pytest -v %a",
  },
}
