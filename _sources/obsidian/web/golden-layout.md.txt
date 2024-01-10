# Version
## 2
- [Version 2 | golden-layout](https://golden-layout.github.io/golden-layout/version-2/)

# tyeps
## LayoutConfig

```ts
/** @public */
export declare interface LayoutConfig {
    root: RootItemConfig | undefined;
    /** @deprecated Use {@link (LayoutConfig:interface).root} */
    content?: (RowOrColumnItemConfig | StackItemConfig | ComponentItemConfig)[];
    openPopouts?: PopoutLayoutConfig[];
    dimensions?: LayoutConfig.Dimensions;
    settings?: LayoutConfig.Settings;
    /** @deprecated use {@link (LayoutConfig:interface).header} instead */
    labels?: LayoutConfig.Labels;
    header?: LayoutConfig.Header;
}
```

## RootItemConfig

```ts
/** @public */
export declare type RootItemConfig = RowOrColumnItemConfig | StackItemConfig | ComponentItemConfig;
```

## ComponentItemConfig

```ts
/** @public */
export declare interface ComponentItemConfig extends HeaderedItemConfig {
    type: 'component';
    readonly content?: [];
    /**
     * The title of the item as displayed on its tab and on popout windows
     * Default: componentType.toString() or ''
     */
    title?: string;
    /**
     * The type of the component.
     * @deprecated use {@link (ComponentItemConfig:interface).componentType} instead
     */
    componentName?: string;
    /**
     * The type of the component.
     * `componentType` must be of type `string` if it is registered with any of the following functions:
     * * {@link (GoldenLayout:class).registerComponent} (deprecated)
     * * {@link (GoldenLayout:class).registerComponentConstructor}
     * * {@link (GoldenLayout:class).registerComponentFactoryFunction}
     */
    componentType: JsonValue;
    /**
     * The state information with which a component will be initialised with.
     * Will be passed to the component constructor function and will be the value returned by
     * container.initialState.
     */
    componentState?: JsonValue;
    /**
     * Default: true
     */
    reorderEnabled?: boolean;
}
```

