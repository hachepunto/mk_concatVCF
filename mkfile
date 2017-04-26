<config.mk

CONCATVCF_PREREQ = `{./bin/prereq}

results/concatVCF/$CONCATVCF_NAME.vcf.gz:D:	$CONCATVCF_PREREQ
	mkdir -p `dirname $target`
	vcf-concat \
		$prereq \
	| gzip \
		-c \
	> $target.build \
	&& mv $target.build $target
