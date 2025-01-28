```cs
public interface ITimeControl
{
    /// <summary>
    /// Called each frame the Timeline clip is active.
    /// </summary>
    /// <param name="time">The local time of the associated Timeline clip.</param>
    void SetTime(double time);

    /// <summary>
    /// Called when the associated Timeline clip becomes active.
    /// </summary>
    void OnControlTimeStart();

    /// <summary>
    /// Called when the associated Timeline clip becomes deactivated.
    /// </summary>
    void OnControlTimeStop();
}
```

- [【Unity】ITimeControlで、Timelineから"コンポーネント"を操作する - テラシュールブログ](https://tsubakit1.hateblo.jp/entry/2017/09/21/234138)
