# 28 "lexertotex.mll"
 
open Parsing_helper
open Piptree
open Fileprint

type kind =
    Keyword
  | Fun
  | Cst
  | Pred

let kinds = Hashtbl.create 7

let init_kinds d = 
  Hashtbl.iter (fun keyw _ -> Hashtbl.add kinds keyw "\\kwl") Pilexer.keyword_table;
  List.iter (function
      FunDecl((f,_),_,_) -> Hashtbl.add kinds f "\\kwf"
    | DataFunDecl((f,_),_) -> Hashtbl.add kinds f "\\kwf"
    | Reduc((((PFunApp((f,_),_) ,_),_)::_),_) -> Hashtbl.add kinds f "\\kwf"
    | PredDecl((p,_),_,_) -> Hashtbl.add kinds p "\\kwp"
    | Free(l,_) -> List.iter (fun (c,_) -> Hashtbl.add kinds c "\\kwc") l
    | _ -> ()) d

let parse filename = 
  try
    let ic = open_in filename in
    let lexbuf = Lexing.from_channel ic in
    let ptree =
      try
        Piparser.all Pilexer.token lexbuf
      with Parsing.Parse_error ->
        input_error "Syntax error" (extent lexbuf)
    in
    close_in ic;
    ptree
  with Sys_error s ->
    user_error ("File error: " ^ s ^ "\n")


# 42 "lexertotex.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\228\255\229\255\078\000\000\000\235\255\236\255\237\255\
    \238\255\239\255\002\000\241\255\242\255\003\000\244\255\245\255\
    \246\255\004\000\001\000\077\000\096\000\002\000\253\255\187\000\
    \001\000\255\255\093\000\002\000\219\000\005\000\007\000\030\000\
    \032\000\063\000\064\000\249\255\074\000\105\000\109\000\146\000\
    \252\255\253\255\005\000\254\255\101\000\255\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\027\000\027\000\255\255\255\255\255\255\
    \255\255\255\255\015\000\255\255\255\255\012\000\255\255\255\255\
    \255\255\007\000\008\000\005\000\004\000\003\000\255\255\001\000\
    \000\000\255\255\255\255\255\255\255\255\021\000\024\000\255\255\
    \255\255\022\000\023\000\255\255\255\255\015\000\025\000\255\255\
    \255\255\255\255\001\000\255\255\003\000\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\255\255\000\000\000\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
    \255\255\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\000\000\255\255\255\255\255\255\040\000\
    \000\000\000\000\255\255\000\000\255\255\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\022\000\025\000\025\000\021\000\024\000\021\000\043\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \023\000\011\000\037\000\013\000\017\000\029\000\005\000\030\000\
    \018\000\016\000\007\000\035\000\017\000\004\000\008\000\009\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\006\000\012\000\003\000\010\000\029\000\036\000\
    \029\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\015\000\034\000\014\000\033\000\033\000\
    \034\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\032\000\013\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\020\000\
    \038\000\037\000\032\000\031\000\030\000\038\000\045\000\000\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\031\000\030\000\043\000\000\000\000\000\042\000\
    \000\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\000\000\044\000\000\000\000\000\020\000\
    \000\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\028\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\026\000\
    \010\000\000\000\000\000\028\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\026\000\
    \010\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\013\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\013\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\041\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\024\000\000\000\000\000\021\000\042\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\010\000\013\000\017\000\029\000\000\000\030\000\
    \000\000\000\000\000\000\018\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\004\000\010\000\
    \027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\031\000\000\000\032\000\033\000\
    \034\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\003\000\000\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\020\000\
    \036\000\037\000\026\000\003\000\003\000\038\000\044\000\255\255\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\026\000\026\000\039\000\255\255\255\255\039\000\
    \255\255\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\255\255\039\000\255\255\255\255\020\000\
    \255\255\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\023\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \023\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\023\000\
    \023\000\255\255\255\255\028\000\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \028\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\028\000\
    \028\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\023\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\028\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\039\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
  __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 70 "lexertotex.mll"
     ( print_string "$\\\\\n$"; token lexbuf )
# 208 "lexertotex.ml"

  | 1 ->
# 72 "lexertotex.mll"
     ( print_string "\\ "; token lexbuf )
# 213 "lexertotex.ml"

  | 2 ->
# 74 "lexertotex.mll"
     ( print_string "\\qquad\\qquad "; token lexbuf )
# 218 "lexertotex.ml"

  | 3 ->
# 76 "lexertotex.mll"
     ( token lexbuf )
# 223 "lexertotex.ml"

  | 4 ->
# 78 "lexertotex.mll"
     ( 
       let s = Lexing.lexeme lexbuf in
       begin
	 try
           let k = Hashtbl.find kinds s in
	   print_string (k ^ "{");
	   print_sanitize s;
	   print_string "}"
	 with Not_found ->
	   print_string "\\var{";
	   print_sanitize s;
	   print_string "}"
       end;
       token lexbuf
     )
# 242 "lexertotex.ml"

  | 5 ->
# 94 "lexertotex.mll"
     ( print_string (Lexing.lexeme lexbuf); token lexbuf )
# 247 "lexertotex.ml"

  | 6 ->
# 95 "lexertotex.mll"
       (
         print_string "\\textit{(*";
         comment lexbuf
       )
# 255 "lexertotex.ml"

  | 7 ->
# 99 "lexertotex.mll"
              ( print_string ", "; token lexbuf )
# 260 "lexertotex.ml"

  | 8 ->
# 100 "lexertotex.mll"
      ( print_string "("; token lexbuf )
# 265 "lexertotex.ml"

  | 9 ->
# 101 "lexertotex.mll"
      ( print_string ")"; token lexbuf )
# 270 "lexertotex.ml"

  | 10 ->
# 102 "lexertotex.mll"
      ( print_string "["; token lexbuf )
# 275 "lexertotex.ml"

  | 11 ->
# 103 "lexertotex.mll"
      ( print_string "]"; token lexbuf )
# 280 "lexertotex.ml"

  | 12 ->
# 104 "lexertotex.mll"
                      ( print_string "\\mid"; token lexbuf )
# 285 "lexertotex.ml"

  | 13 ->
# 105 "lexertotex.mll"
      ( print_string ";"; token lexbuf )
# 290 "lexertotex.ml"

  | 14 ->
# 106 "lexertotex.mll"
      ( print_string "!"; token lexbuf )
# 295 "lexertotex.ml"

  | 15 ->
# 107 "lexertotex.mll"
                      ( print_string " = "; token lexbuf )
# 300 "lexertotex.ml"

  | 16 ->
# 108 "lexertotex.mll"
      ( print_string "/"; token lexbuf )
# 305 "lexertotex.ml"

  | 17 ->
# 109 "lexertotex.mll"
      ( print_string "."; token lexbuf )
# 310 "lexertotex.ml"

  | 18 ->
# 110 "lexertotex.mll"
      ( print_string "*"; token lexbuf )
# 315 "lexertotex.ml"

  | 19 ->
# 111 "lexertotex.mll"
      ( print_string "{:}"; token lexbuf )
# 320 "lexertotex.ml"

  | 20 ->
# 112 "lexertotex.mll"
      ( print_string "\\&"; token lexbuf )
# 325 "lexertotex.ml"

  | 21 ->
# 113 "lexertotex.mll"
                       ( print_string (if !nice_tex then "\\rightarrow" else "\\ {-}{>}\\ "); token lexbuf )
# 330 "lexertotex.ml"

  | 22 ->
# 114 "lexertotex.mll"
                        ( print_string (if !nice_tex then "\\leftrightarrow" else "\\ {<}{-}{>}\\ "); token lexbuf )
# 335 "lexertotex.ml"

  | 23 ->
# 115 "lexertotex.mll"
                        ( print_string (if !nice_tex then "\\Leftrightarrow" else "\\ {<}{=}{>}\\ "); token lexbuf )
# 340 "lexertotex.ml"

  | 24 ->
# 116 "lexertotex.mll"
                       ( print_string (if !nice_tex then "\\neq" else "\\ {<}{>}\\ "); token lexbuf )
# 345 "lexertotex.ml"

  | 25 ->
# 117 "lexertotex.mll"
                        ( print_string (if !nice_tex then "\\Longrightarrow" else "\\ {=}{=}{>}\\ "); token lexbuf )
# 350 "lexertotex.ml"

  | 26 ->
# 118 "lexertotex.mll"
      (  print_string "$\n\\end{tabbing}\n" )
# 355 "lexertotex.ml"

  | 27 ->
# 119 "lexertotex.mll"
    ( input_error "Illegal character" (extent lexbuf) )
# 360 "lexertotex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and comment lexbuf =
  __ocaml_lex_comment_rec lexbuf 39
and __ocaml_lex_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 122 "lexertotex.mll"
       ( print_string "*)}";
         token lexbuf )
# 372 "lexertotex.ml"

  | 1 ->
# 125 "lexertotex.mll"
     ( print_string "}$\\\\\n$\\textit{"; comment lexbuf )
# 377 "lexertotex.ml"

  | 2 ->
# 126 "lexertotex.mll"
      ( print_string "}$\n\\end{tabbing}\n" )
# 382 "lexertotex.ml"

  | 3 ->
# 127 "lexertotex.mll"
    ( print_sanitize (Lexing.lexeme lexbuf); comment lexbuf )
# 387 "lexertotex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_comment_rec lexbuf __ocaml_lex_state

;;

# 129 "lexertotex.mll"
 

let convert filename = 
  try
    let ic = open_in filename in
    let lexbuf = Lexing.from_channel ic in
    print_preamble();
    print_string "\\begin{tabbing}\n$";
    token lexbuf;
    close_in ic
  with Sys_error s ->
    user_error ("File error: " ^ s ^ "\n")

let converttotex f =
  let d = parse f in
  init_kinds d;
  convert f 


# 413 "lexertotex.ml"
