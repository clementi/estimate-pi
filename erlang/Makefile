bin: ./main.beam

./main.beam: ./main.erl
	erlc ./main.erl

run: ./main.beam
	erl -noshell -pa ./main.beam -s main start -s init stop

clean: ./main.beam
	rm -f ./main.beam
