:- module(dcgs, [digitize_string//1]).

digitize_string(String), T -->
    { string_codes(String, [_|T]) },
    String.
