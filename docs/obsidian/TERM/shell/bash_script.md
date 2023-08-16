[[bash]]

# Array
- [【Bashシェル】配列の基本的な使い方 | 秋拓技術学院](https://syutaku.blog/bash-array/)
- [Bash の配列 - Bash スクリプトで文字列の配列を宣言する方法](https://www.freecodecamp.org/japanese/news/bash-array-how-to-declare-an-array-of-strings-in-a-bash-script/)

```sh
myArray=("cat" "dog" "mouse" "frog")

echo ${myArray[@]}

for str in ${myArray[@]}; do
  echo $str
done
```
### split
```sh
LIN=${PATH//:/ }
WIN=${PATH//;/ }
```
