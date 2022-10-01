local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node

local F = require "myfunc"

ls.add_snippets("all", {
  s("today", t(F.today('%Y%m%d'))),
  s("yyyymmdd", t "%Y%m%d"),
  s("yyyy-mm-dd", t "%Y-%m-%d"),
})

ls.add_snippets("bigquery", {
  s("init", t {
    [[#standardSQL]],
    string.format(
      "create temp function start_date() as (date '%s');",
      F.today('%Y-%m-%d')
    ),
    [[create temp function start_date_str(format string) as (]],
    "\tformat_date(format, start_date())",
    [[);]],
    string.format(
      "create temp function end_date() as (date '%s');",
      F.today('%Y-%m-%d')
    ),
    [[create temp function end_date_str(format string) as (]],
    "\tformat_date(format, end_date())",
    [[);]],
  }),
  -- script
  s("loop", {
    t {
      "declare i int64 default 0;",
      "loop",
      "\tset i = i + 1;",
      "\tif i >= 0 then leave; end if;",
      "\t",
    },
    i(0),
    t {
      "",
      "end loop;",
    }
  }),
  -- other
  s("rows", t [[rows between unbounded preceding and unbounded following]]),
  s("range", t [[range between unbounded preceding and unbounded following]]),
})

ls.add_snippets("python", {
  s("docstring", t [[#standardSQL]]),
})

ls.add_snippets("sh", {
  s("init", t {
    [[#!/bin/bash]],
    [[set -euo pipefail]],
    [[cd $(dirname $0)]],
  }),
})
