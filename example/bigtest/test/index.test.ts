import { test } from '@bigtest/suite';
import { App, Heading } from '@bigtest/interactor';

export default test("foo")
    .step(App.visit("/"))
    .assertion(Heading("Hello world").exists());