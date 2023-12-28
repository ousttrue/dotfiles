namespace mymodule;

public class Dependency
{
    public string Name;
    public string Url;
    public string Exe;

    public Dependency(string name, string url, string exe)
    {
        Name = name;
        Url = url;
        Exe = exe;
    }

    public override string ToString()
    {
        return $"[{Name}]";
    }

    public string GetArchive()
    {
        return System.IO.Path.GetFileName(Url);
    }
}