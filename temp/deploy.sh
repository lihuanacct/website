cd D:/Develop/workspace/javaworkspace/website/source/temp/
echo -e "\033[47;30m>>>>>>>>>>>>>>>>>>>>获取文件名<<<<<<<<<<<<<<<<<<<<\033[0m"
#!/bin/bash

cd D:/Develop/workspace/javaworkspace/website/source/temp/
#获取文件名
filename=$(ls *.md)
#去掉后缀
filename_no_ext="${filename%.*}"

echo -e "\033[47;30m>>>>>>>>>>>>>>>>>>>>开始写入front-matter<<<<<<<<<<<<<<<<<<<<\033[0m"

#获取第一行的内容
first_line1=$(sed -n '1p' $filename)
#获取第二行的内容
first_line2=$(sed -n '2p' $filename)

#删除第一行、第二行的内容
sed -i '1,2d' $filename

#写入front-matter
sed -i '1i\\n' $filename
sed -i '1i\---' $filename
sed -i '1i\categories: 测试' $filename
sed -i '1i\tags: 测试' $filename
sed -i '1i\date: ${date}' $filename
sed -i "1i\\title: ${filename_no_ext}" "$filename"
sed -i '1i\---' $filename

#替换分类和标签的值
sed -i "4s/测试/${first_line1}/" $filename
sed -i "5s/测试/${first_line2}/" $filename

echo -e "\033[47;30m>>>>>>>>>>>>>>>>>>>>开始复制并删除原文件<<<<<<<<<<<<<<<<<<<<\033[0m"

cp $(ls *.md) D:/Develop/workspace/javaworkspace/website/source/_posts/ && rm -f $(ls *.md)

echo -e "\033[47;30m>>>>>>>>>>>>>>>>>>>>发布文章<<<<<<<<<<<<<<<<<<<<\033[0m"

cd D:/Develop/workspace/javaworkspace/website
echo -e "\033[47;30m>>>>>>>>>>>>>>>>>>>>hexo g<<<<<<<<<<<<<<<<<<<<\033[0m"
npx hexo g
echo -e "\033[47;30m>>>>>>>>>>>>>>>>>>>>hexo d<<<<<<<<<<<<<<<<<<<<\033[0m"
npx hexo d
sleep 5

