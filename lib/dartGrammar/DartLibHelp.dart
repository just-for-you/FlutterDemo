
library logger_lib;


// 使用下划线(_)为标识符添加前缀，以将其组件标记为私有
// 标记私有函数
void _log(msg) {
  print("Log method called in loggerlib ====== $msg");
}


void log(msg) {
  print("Log method called in loggerlib ====== $msg");
}
