import React from "react";
import { micromark } from "micromark";
import type {
  Extension,
  Tokenizer,
  Effects,
  State,
  Code,
} from "micromark-util-types";

export const HelloStory = () => <div>hello!</div>;

const MD = `
Hello, {planet}!

{pla\}net} and {pla&#x7d;net}.
`;

const variableTokenize: Tokenizer = (effects, ok, nok) => {
  const inside: State = (code: Code) => {
    if (code === -5 || code === -4 || code === -3 || code === null) {
      return nok(code);
    }

    if (code === 125) {
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
    return begin;
  };
  return start;
};

export function MarkdownStory() {
  const variableConstruct = {
    name: "variable",
    tokenize: variableTokenize,
  };

  const variables = { text: { 123: variableConstruct } } satisfies Extension;

  const out = micromark(MD, { extensions: [variables] });
  // console.log(out)

  return <pre>{out}</pre>;
}
