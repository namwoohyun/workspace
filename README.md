# workspace
主要有四个文件，decisiontree.v是决策树的代码实现，decisiontree_test是测试文件，decision.txt中存放决策树的二进制代码，x_i.txt中存放输入信号x1_i-xn_i；本次设计使用iverilog进行功能仿真，根据文件中的内容最终输出为Y1。
  使用微程序设计思想，将决策树放入可修改的ram中，通过文件读写的方式可以修改决策树。
  输入数据通过一个数组保存，可根据决策树的变化使用文件读取的方式动态地修改输入信号的个数。
