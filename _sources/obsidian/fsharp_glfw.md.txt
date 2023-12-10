[[fsharp]]

```fsharp
open Silk.NET.GLFW
open Microsoft.FSharp.NativeInterop


type GlfwWindow(glfw: Glfw, handle: nativeptr<WindowHandle>) =
    let glfw = glfw
    let handle = handle

    member _.IsClosing() : bool = glfw.WindowShouldClose handle

    interface System.IDisposable with
        member _.Dispose() =
            printfn "glfw.DestroyWindow()"
            glfw.DestroyWindow(handle)


type GlfwApp() =
    let glfw = GlfwProvider.GLFW.Value

    do
        if not <| glfw.Init() then
            failwith "Failed to initialize GLFW"

        printfn "glfw.Init()"


    member _.CreateWindow width height title : Option<GlfwWindow> =
        do glfw.WindowHint(WindowHintClientApi.ClientApi, ClientApi.NoApi)

        let window =
            glfw.CreateWindow(width, height, title, NativePtr.nullPtr, NativePtr.nullPtr)

        if window = NativePtr.nullPtr then
            printfn "glfw.CreateWindow() fail"
            None
        else
            printfn "glfw.CreateWindow()"
            Some(new GlfwWindow(glfw, window))


    member _.Poll() = glfw.PollEvents()

    interface System.IDisposable with
        member _.Dispose() =
            printfn "glfw.Terminate()"
            glfw.Terminate()


let rec Loop (app: GlfwApp) (window: GlfwWindow) =
    if not <| window.IsClosing() then
        app.Poll()
        Loop app window


[<EntryPoint>]
let main (argv: string []) : int =
    printfn "Creating WGPU instance"
    let instance = WGPU.Native.Instance()

    use app = new GlfwApp()

    match app.CreateWindow 600 600 "wgpu-native-fs" with
    | Some (window) ->
        use window = window
        Loop app window
        0
    | None -> 1
```