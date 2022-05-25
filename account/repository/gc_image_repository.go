package repository

import (
	storage "cloud.google.com/go/storage"
	"github.com/pirateXXOO/memrizr/account/model"
)

type gcImageRepository struct {
	Storage    *storage.Client
	BucketName string
}

// NewImageRepository is a factory for initializing User Repositories
func NewImageRepository(gcClient *storage.Client, bucketName string) model.ImageRepository {
	return &gcImageRepository{
		Storage:    gcClient,
		BucketName: bucketName,
	}
}
