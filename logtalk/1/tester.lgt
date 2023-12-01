:- initialization((
    set_logtalk_flag(debug, on), set_logtalk_flag(source_data, on),
	logtalk_load([
      lgtunit(loader),
	  assertions(loader),
      hook_flows(loader),
      loader]),
    Hooks = [assertions(debug), lgtunit],
    logtalk_load([test], [hook(hook_set(Hooks))]),
	findall(T, (current_object(T), extends_object(T, lgtunit)), Ts),
    lgtunit::run_test_sets(Ts)
)).
