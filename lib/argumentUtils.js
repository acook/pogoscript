((function() {
    var self;
    self = this;
    exports.asyncifyArguments = function(arguments, optionalArguments) {
        var self, gen1_items, gen2_i, arg, gen3_items, gen4_i;
        self = this;
        gen1_items = arguments;
        for (gen2_i = 0; gen2_i < gen1_items.length; gen2_i++) {
            arg = gen1_items[gen2_i];
            arg.asyncify();
        }
        gen3_items = optionalArguments;
        for (gen4_i = 0; gen4_i < gen3_items.length; gen4_i++) {
            arg = gen3_items[gen4_i];
            arg.asyncify();
        }
    };
})).call(this);