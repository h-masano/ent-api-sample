#!/bin/bash

make migrate-drop FORCE=-f
make migrate-up
go run ./api/
