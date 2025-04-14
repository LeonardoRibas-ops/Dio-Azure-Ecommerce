from azure.storage.blob import BlobServiceClient
import os
import uuid

def upload_imagem(file):
    blob_service = BlobServiceClient.from_connection_string(os.getenv("AZURE_STORAGE_CONNECTION_STRING"))
    container = os.getenv("AZURE_CONTAINER_NAME")

    blob_name = f"{uuid.uuid4()}_{file.name}"
    blob_client = blob_service.get_blob_client(container=container, blob=blob_name)

    blob_client.upload_blob(file)
    return blob_client.url

