function _M:log(context) 
   ngx.var[ngx_var_access_logs_enabled] = self.enable_access_logs_val 
   if self:use_default_access_logs() then 
     return 
   end 
   -- Extended log is now enaled, disable the default access_log 
   disable_default_access_logs() 
  
   local extended_context = get_request_context(context or {}) 
   if self.condition and not self.condition:evaluate(extended_context) then 
     -- Access log is disabled here, request does not match, so log is disabled 
     -- for this request 
     disable_extended_access_log() 
     return 
   end 
