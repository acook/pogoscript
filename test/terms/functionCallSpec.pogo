terms = require '../../lib/parser/codeGenerator'.code generator ()
should contain fields = require '../containsFields'.contains fields

describe 'function call'
    context 'when the function call is asynchronous'
        it 'returns an async closure when blockify is called'
            function call = terms.function call (terms.variable ['func'], [], async: true)

            block = function call.blockify ([])

            (block) should contain fields (
                terms.closure (
                    []
                    terms.async statements [
                        terms.function call (terms.variable ['func'], [], async: true)
                    ]
                )
            )

        context 'and a non-asynchronous block is passed'
            it 'asyncifies the block'
                function call =
                    terms.function call (
                        terms.variable ['func']
                        [
                            terms.closure (
                                []
                                terms.statements [
                                    terms.variable ['a']
                                ]
                            )
                        ]
                        async: true
                    )

                block arg =
                    terms.closure (
                        []
                        terms.statements [
                            terms.variable ['a']
                        ]
                    )

                block arg.asyncify ()

                expected function call =
                    terms.function call (
                        terms.variable ['func']
                        [
                            block arg
                        ]
                        async: true
                    )

                (function call) should contain fields (expected function call)

        context 'and a non-asynchronous block is passed as an optional argument'
            it 'asyncifies the block'
                function call =
                    terms.function call (
                        terms.variable ['func']
                        []
                        optional arguments: [
                            terms.hash entry (
                                ['block']
                                terms.closure (
                                    []
                                    terms.statements [
                                        terms.variable ['a']
                                    ]
                                )
                            )
                        ]
                        async: true
                    )

                block arg =
                    terms.closure (
                        []
                        terms.statements [
                            terms.variable ['a']
                        ]
                    )

                block arg.asyncify ()

                expected function call =
                    terms.function call (
                        terms.variable ['func']
                        []
                        optional arguments: [
                            terms.hash entry (
                                ['block']
                                block arg
                            )
                        ]
                        async: true
                    )

                (function call) should contain fields (expected function call)

    context 'when the function call is a future'
        it 'returns a call to future, making the function call async and passing it as a block'
            future call = terms.function call (terms.variable ['f'], [terms.variable ['arg']], future: true)

            callback = terms.generated variable ['callback']

            (future call) should contain fields {
                is function call
                function = {is variable, name ['future']}
                function arguments = [
                    terms.closure (
                        [callback]
                        terms.statements [
                            terms.function call (
                                terms.variable ['f']
                                [terms.variable ['arg']]
                                originally async: true
                                async callback argument: callback
                            )
                        ]
                    )
                ]
            }
