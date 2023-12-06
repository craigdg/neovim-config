export function test(): void {
  console.log("hello", 0);
  return;
}

			import { Dummy } from "./import.test.ts";

// Comment

export abstract class Test<T> {
  public foo(arg: T): string {
    if (typeof arg === "string") {
      return arg;
    }

    const tests = [];
	 
    for (const test of tests) {
	    console.log(test)
    }

    console.log(arg);

    return "";
  }

  public static bar(): void {
    return;
  }
}

const dummy = new Dummy();

dummy.method();
dummy.method();
dummy.bam();
dummy.bam();
