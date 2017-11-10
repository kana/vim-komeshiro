" komeshiro - An eyecandy
" Version: 0.0.0
" Copyright (C) 2017 Kana Natsuno <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Variables  "{{{1

let s:enabled = v:true

let s:fade_timer = 0
let s:start_timer = 0

let s:MIN_STEP = 0
let s:MAX_STEP = 100
let s:step = s:MIN_STEP
let s:first_transparency = 0
let s:LAST_TRANSPARENCY = 100








" Interface  "{{{1

function! komeshiro#onFocusLost()
  if !s:enabled
    return
  endif

  let s:first_transparency = &transparency
  let s:start_timer = timer_start(2000, 'komeshiro#_start')
endfunction

function! komeshiro#onFocusGained()
  if !s:enabled
    return
  endif

  let &transparency = s:first_transparency
  call timer_stop(s:start_timer)
  call timer_stop(s:fade_timer)
endfunction

function! komeshiro#enable()
  let s:enabled = v:true
endfunction

function! komeshiro#disable()
  let s:enabled = v:false
endfunction








" Misc.  "{{{1

function! komeshiro#_start(_timer)
  let s:step = s:MIN_STEP
  let s:fade_timer = timer_start(10, 'komeshiro#_fade', {'repeat': s:MAX_STEP})
endfunction

function! komeshiro#_fade(_timer)
  let s:step += 1
  let d = s:LAST_TRANSPARENCY - s:first_transparency
  let t = s:first_transparency + 1.0 * d * s:step / s:MAX_STEP
  let &transparency = float2nr(t)
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
