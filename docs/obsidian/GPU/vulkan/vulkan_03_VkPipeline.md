# Pipeline

- [Vulkan Compute入門](https://zenn.dev/nishiki/articles/c67f1e1de294e1)

# setup

## VkCommandPool

```cpp
bool make_commandpool(VkDevice device, uint32_t graphics_queue_family_index, VkCommandPool *commandPool)
{
  VkCommandPoolCreateInfo poolInfo{
    .sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO,
    .flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT,
    .queueFamilyIndex = graphics_queue_family_index,
  };
  if (vkCreateCommandPool(device, &poolInfo, nullptr, commandPool) != VK_SUCCESS) {
    return false;
  }
  return true;
}
```

## VkCommandBuffer

```cpp
bool make_commandbuffer(VkDevice device, VkCommandPool commandPool, VkCommandBuffer *commandBuffer)
{
  VkCommandBufferAllocateInfo allocInfo{
    .sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO,
    .commandPool = commandPool,
    .level = VK_COMMAND_BUFFER_LEVEL_PRIMARY,
    .commandBufferCount = 1,
  };
  if (vkAllocateCommandBuffers(device, &allocInfo, commandBuffer) != VK_SUCCESS) {
    return false;
  }
  return true;
}
```

# use

```cpp
void recordCommandBuffer(VkCommandBuffer commandBuffer, uint32_t imageIndex) {
  VkCommandBufferBeginInfo beginInfo{
    .sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO,
    .flags = 0, // Optional
    .pInheritanceInfo = nullptr, // Optional
  };

  if (vkBeginCommandBuffer(commandBuffer, &beginInfo) != VK_SUCCESS) {
      throw std::runtime_error("failed to begin recording command buffer!");
  }

    vkCmdBeginRenderPass(commandBuffer, &renderPassInfo, VK_SUBPASS_CONTENTS_INLINE); // clear

      vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_GRAPHICS, graphicsPipeline);
      vkCmdDraw(commandBuffer, 3, 1, 0, 0);

    vkCmdEndRenderPass(commandBuffer); // submit

  if (vkEndCommandBuffer(commandBuffer) != VK_SUCCESS) { // flush
      throw std::runtime_error("failed to record command buffer!");
  }
}
```
