package main

import (
	"log"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/h-masano/ent-api-sample/database/ent"
	_ "github.com/lib/pq"
)

func main() {

	// create db client with ent
	client, err := ent.Open("postgres", "host=ent-api-sample-db-1 port=5432 user=root dbname=sampledb password=password sslmode=disable")
	if err != nil {
		log.Fatalf("failed opening connection to postgres: %v", err)
	}

	r := gin.Default()

	// get all users
	r.GET("/users", func(c *gin.Context) {
		users, err := client.Users.Query().All(c)
		if err != nil {
			c.JSON(500, gin.H{"error": err})
			return
		}
		c.JSON(200, users)
	})

	// put user
	r.PUT("/user", func(c *gin.Context) {
		age := c.Query("age")
		name := c.Query("name")

		ageInt, err := strconv.Atoi(age)
		if err != nil {
			c.JSON(400, gin.H{"error": "age must be integer"})
			return
		}

		user, err := client.Users.Create().SetAge(ageInt).SetName(name).Save(c)
		if err != nil {
			c.JSON(500, gin.H{"error": err})
			return
		}
		c.JSON(200, user)
	})
}
