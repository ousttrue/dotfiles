[[cpp]]

- [Asio C++ Library](https://think-async.com/Asio/)
	- [Overview](https://think-async.com/Asio/asio-1.24.0/doc/asio/overview.html)
	- [Reference](https://think-async.com/Asio/asio-1.24.0/doc/asio/reference.html)
	- [Examples](https://think-async.com/Asio/asio-1.24.0/doc/asio/examples.html)

- @2015 [boost.Asioを半年使っわかったこと - Qiita](https://qiita.com/YukiMiyatake/items/5be12ea35894071d8de1)
- @2011 [Boost.Asio ゲームループで非同期操作を行う - Faith and Brave - C++で遊ぼう](https://faithandbrave.hateblo.jp/entry/20110325/1301036991)
- @2011 [Boost.Asio リンク集 - Cube Lilac](https://clown.cube-soft.jp/entry/20110325/1301048795)

# callback
 - @2016 [Asioで非同期Http通信 - C++と色々](https://nekko1119.hatenablog.com/entry/2016/04/08/051907)

# future 

# promise
```c++
#include <asio/experimental/promise.hpp>

asio::experimental::use_promise
```
- @2017 [Boost.ASIO で callback | coroutine | future による非同期IO - Qiita](https://qiita.com/legokichi/items/3365b25eea13c0f2bb51)

# coroutine
`c++20`
[[cpp_coroutine]]

# The Networking TS
- [Extensions for networking - cppreference.com](https://en.cppreference.com/w/cpp/experimental/networking)

- [Asio カテゴリーの記事一覧 - あめだまふぁくとりー](https://amedama1x1.hatenablog.com/archive/category/Asio)
	- @2016 [Networking TS の Boost.Asio からの変更点 - その 3: Executor - あめだまふぁくとりー](https://amedama1x1.hatenablog.com/entry/2016/08/20/222326)
	- `io_service => io_context`
 
# asio::buffer
- @2018 [boost.asioのTCP/UDP通信時のBufferに関するメモ - 地面を見下ろす少年の足蹴にされる私](https://onihusube.hatenablog.com/entry/2018/05/26/011129)
- @2015 [【boost::asio buffers】 boost::asioでセッション管理にはshared_ptrが便利だ - Qiita](https://qiita.com/YukiMiyatake/items/f4641c54151a18c362f9)
