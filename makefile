default:
	@docker build -t carwow/ds-python .

upload: default
	@docker push carwow/ds-python
