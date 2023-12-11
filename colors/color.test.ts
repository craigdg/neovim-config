import { Dummy } from "./import.test.ts";

export function test(): void {
    console.log("hello", 0);
    return;
}

// Comment
export abstract class Test<T> {
    public foo(arg: T): string {
        if (typeof arg === "string") {
            return arg;
        }

        const tests = [];

        for (const test of tests) {
            console.log(test);
        }

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
