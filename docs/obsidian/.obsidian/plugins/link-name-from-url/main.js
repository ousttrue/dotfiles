/*
THIS IS A GENERATED/BUNDLED FILE BY ESBUILD
if you want to view the source, please visit the github repository of this plugin
*/

var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);
var __async = (__this, __arguments, generator) => {
  return new Promise((resolve, reject) => {
    var fulfilled = (value) => {
      try {
        step(generator.next(value));
      } catch (e) {
        reject(e);
      }
    };
    var rejected = (value) => {
      try {
        step(generator.throw(value));
      } catch (e) {
        reject(e);
      }
    };
    var step = (x) => x.done ? resolve(x.value) : Promise.resolve(x.value).then(fulfilled, rejected);
    step((generator = generator.apply(__this, __arguments)).next());
  });
};

// main.ts
var main_exports = {};
__export(main_exports, {
  default: () => LinkNameFromUrlPlugin
});
module.exports = __toCommonJS(main_exports);
var import_obsidian = require("obsidian");
var DEFAULT_SETTINGS = {
  autoConvert: true
};
var isValidURL = (url) => {
  if (url.endsWith(")") || url.startsWith("[") || url.includes("]("))
    return false;
  let urlObj;
  try {
    urlObj = new URL(url);
  } catch (_) {
    return false;
  }
  return urlObj.protocol === "http:" || urlObj.protocol === "https:";
};
var urlToHyperlink = (url) => {
  if (!isValidURL(url))
    return url;
  const elements = url.split("/");
  let name = elements[elements.length - 1] !== "" ? elements[elements.length - 1] : elements[elements.length - 2];
  name = name.split(".")[0].split("?")[0].replace(/-|_/gm, " ").split(" ").map((word) => word.charAt(0).toUpperCase() + word.slice(1)).join(" ");
  return `[${name}](${url})`;
};
var convertUrlsFromString = (text) => {
  text = text.replace(/(https?|ftp):\/\/[^\s/$.?#].[^\s,]*/ig, urlToHyperlink);
  return text;
};
var LinkNameFromUrlPlugin = class extends import_obsidian.Plugin {
  onload() {
    return __async(this, null, function* () {
      yield this.loadSettings();
      this.addCommand({
        id: "get-link-name-from-url",
        name: "Get link name from URL",
        checkCallback: (checking) => {
          const view = this.app.workspace.getActiveViewOfType(import_obsidian.MarkdownView);
          if (!view)
            return false;
          const view_mode = view.getMode();
          switch (view_mode) {
            case "source":
              if (!checking) {
                if ("editor" in view) {
                  const selection = view.editor.getSelection();
                  if (!selection.includes("http"))
                    return false;
                  view.editor.replaceSelection(convertUrlsFromString(selection));
                }
              }
              return true;
            default:
              return false;
          }
        }
      });
      this.addSettingTab(new SettingTab(this.app, this));
      if (this.settings.autoConvert) {
        this.registerEvent(this.app.workspace.on("editor-paste", (clipboard) => {
          const view = this.app.workspace.getActiveViewOfType(import_obsidian.MarkdownView);
          if (!view || !this.settings.autoConvert)
            return false;
          const clipboardText = clipboard.clipboardData.getData("text/plain").trim();
          if (clipboardText == null || clipboardText == "")
            return;
          if (!clipboardText.includes("http"))
            return;
          clipboard.stopPropagation();
          clipboard.preventDefault();
          view.editor.replaceSelection(convertUrlsFromString(clipboardText));
        }));
      }
    });
  }
  onunload() {
  }
  loadSettings() {
    return __async(this, null, function* () {
      this.settings = Object.assign({}, DEFAULT_SETTINGS, yield this.loadData());
    });
  }
  saveSettings() {
    return __async(this, null, function* () {
      yield this.saveData(this.settings);
    });
  }
};
var SettingTab = class extends import_obsidian.PluginSettingTab {
  constructor(app, plugin) {
    super(app, plugin);
    this.plugin = plugin;
  }
  display() {
    const { containerEl } = this;
    containerEl.empty();
    new import_obsidian.Setting(containerEl).setName("Auto convert").setDesc("Automatically convert links to hyperlinks with name.").addToggle((text) => text.setValue(this.plugin.settings.autoConvert).onChange((value) => __async(this, null, function* () {
      this.plugin.settings.autoConvert = value;
      yield this.plugin.saveSettings();
    })));
  }
};