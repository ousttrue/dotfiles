namespace MyPSModule

open System.Management.Automation

[<Cmdlet("Get", "Foo")>]
type GetFooCommand() =
    inherit PSCmdlet()

    [<Parameter>]
    member val Name: string = "" with get, set

    override x.EndProcessing() =
        x.WriteObject("Foo is " + x.Name)
        base.EndProcessing()
