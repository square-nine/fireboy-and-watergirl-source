
{
   return logger.add(Tracer,Firebug);
}

package com.miniclip
{
   public const logger:Logger = new LogDispatcher("LogDispatcher",LoggingLevel.errors);
}
