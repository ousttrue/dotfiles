- [画面クリアまで 16/07/16 up](https://sites.google.com/site/monshonosuana/vulkan)%E3%81%AE%E8%A9%B1/vulkan%E3%81%AE%E8%A9%B1-%E7%AC%AC2%E5%9B%9E

- [三角形の描画｜ゼロからVulkan Ray Tracing](https://zenn.dev/nishiki/books/f468197dca2dd8/viewer/chapter13)

# resize

- [4-7. スワップチェーンの再作成 | やっていくVulkan入門](https://chaosplant.tech/do/vulkan/4-7/)

# Semaphore and Fence

- [補講2. セマフォとフェンスによる同期処理 | やっていくVulkan入門](https://chaosplant.tech/do/vulkan/ex2/)

## Fence

- submit, wait でブロックできる。

# get, render, wait, present

- https://vulkan-tutorial.com/Drawing_a_triangle/Drawing/Rendering_and_presentation
- https://vulkan-tutorial.com/Drawing_a_triangle/Drawing/Frames_in_flight
- https://developer.arm.com/documentation/101897/0304/System-integration/Optimizing-swapchain-semaphores-for-Vulkan
- https://chaosplant.tech/do/vulkan/4-6/

```cpp
  uint32_t imageIndex;
  vkAcquireNextImageKHR(Device, Swapchain, UINT64_MAX,
                        ImageAvailableSemaphores[CurrentFrame], VK_NULL_HANDLE,
                        &imageIndex);
```

`render`

```cpp
  if (vkQueueSubmit(GraphicsQueue, 1, &submitInfo,
                    InFlightFences[CurrentFrame]) != VK_SUCCESS) {
    LOGE("failed to submit draw command buffer!");
    return false;
  }
```
```cpp
  VkSwapchainKHR swapChains[] = {Swapchain};
  VkPresentInfoKHR presentInfo{
      .sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR,
      .waitSemaphoreCount = 1,
      .pWaitSemaphores = signalSemaphores,
      .swapchainCount = 1,
      .pSwapchains = swapChains,
      .pImageIndices = &imageIndex,
  };
  vkQueuePresentKHR(PresentQueue, &presentInfo);
```
