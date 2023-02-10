[[physics_engine]]

- [衝突判定編](http://marupeke296.com/COL_main.html)

# BroadPhase
衝突可能性のあるペアを得る

```cpp
   virtual void Add(AABB *aabb);
   virtual void Remove(AABB *aabb);
   virtual void Update(void);
   virtual ColliderPairList &ComputePairs(void);

   virtual Collider *Pick(const Vec3 &point) const;
   virtual Query(const AABB &aabb, ColliderList &out) const;
   virtual RayCastResult RayCast(const Ray3 &ray) const;
```


## AABB Tree
- @2017 [Introductory Guide to AABB Tree Collision Detection – Azure From The Trenches](https://www.azurefromthetrenches.com/introductory-guide-to-aabb-tree-collision-detection/)
- @2014 [Game Physics: Broadphase – Dynamic AABB Tree | Ming-Lun "Allen" Chou | 周明倫](https://allenchou.net/2014/02/game-physics-broadphase-dynamic-aabb-tree/)
- @2014 [当たり判定の高速化 – AABB木の使用 | ftvlog](https://ftvoid.com/blog/post/364)

## OctTree / QuadTree
`3D`
- [Octree - Wikipedia](https://en.wikipedia.org/wiki/Octree)
`2D`
- [Quadtree - Wikipedia](https://en.wikipedia.org/wiki/Quadtree)

## BSPTrees

# NarrowPhase
- @2014 [当たり判定の高速化 ‐ スイープ＆プルーンの使用 | ftvlog](https://ftvoid.com/blog/post/407)

# OBB
`Oriented Bounding Box`
[[OBB]]


