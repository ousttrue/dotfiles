import React from "react";
import { micromark } from "micromark";
import type {
  Extension,
  Tokenizer,
  Effects,
  State,
  Code,
  HtmlExtension,
  Handle,
  CompileContext,
} from "micromark-util-types";

export const HelloStory = () => <div>hello!</div>;

//
// https://github.com/micromark/micromark?tab=readme-ov-file#creating-a-micromark-extension
//
// |-------variable-----------|
// |-marker-|
//          |-string-|
//                   |-marker-|
declare module "micromark-util-types" {
  interface TokenTypeMap {
    variable: "variable";
    variableMarker: "variableMarker";
    variableString: "variableString";
  }
}

const MD = `
Hello, {planet}!

{pla\}net} and {pla&#x7d;net}.
`;

const variableTokenize: Tokenizer = (effects, ok, nok) => {
  const insideEscape: State = (code: Code) => {
    if (code === 92 || code === 125) {
      effects.consume(code);
      return inside;
    }

    return inside(code);
  };

  const inside: State = (code: Code) => {
    if (code === -5 || code === -4 || code === -3 || code === null) {
      return nok(code);
    }

    if (code === 92) {
      effects.consume(code);
      return insideEscape;
    }

    if (code === 125) {
      effects.exit("chunkString");
      effects.exit("variableString");
      effects.enter("variableMarker");
      effects.consume(code);
      effects.exit("variableMarker");
      effects.exit("variable");
      return ok;
    }

    effects.consume(code);
    return inside;
  };

  const begin: State = (code: Code) => {
    return code === 125 ? nok(code) : inside(code);
  };

  const start: State = (code: Code) => {
    effects.enter("variable");
    effects.enter("variableMarker");
    effects.consume(code);
    effects.exit("variableMarker");
    effects.enter("variableString");
    effects.enter("chunkString", { contentType: "string" });
    return begin;
  };
  return start;
};

function variablesHtml(data = {}): HtmlExtension {
  const enterVariableString: Handle = function (this: CompileContext) {
    this.buffer();
  };

  const exitVariableString: Handle = function (this: CompileContext) {
    var id = this.resume();
    if (id in data) {
      this.raw(this.encode(data[id]));
    }
  };

  return {
    enter: { variableString: enterVariableString },
    exit: { variableString: exitVariableString },
  };
}

export function MarkdownStory() {
  const variableConstruct = {
    name: "variable",
    tokenize: variableTokenize,
  };

  const html = variablesHtml({ planet: "1", "pla}net": "2" });
  const variables = { text: { 123: variableConstruct } } satisfies Extension;
  const out = micromark(MD, {
    extensions: [variables],
    htmlExtensions: [html],
  });
  // console.log(out)

  return (
    <>
      <textarea defaultValue={MD} />
      <textarea defaultValue={out} />
    </>
  );
}
