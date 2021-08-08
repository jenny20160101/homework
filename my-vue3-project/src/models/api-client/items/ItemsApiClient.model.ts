// import axios, { AxiosRequestConfig, AxiosError, AxiosResponse } from "axios"
import { HttpClient, HttpRequestParamsInterface } from "@/models/http-client"
import { ItemsApiClientUrlsInterface } from "./ItemsApiClientUrls.interface"
import { ItemsApiClientInterface } from "./ItemsApiClient.interface"
import { ItemInterface } from "@/models/items/Item.interface"


export class ItemsApiClientModel implements ItemsApiClientInterface {
    private readonly urls!: ItemsApiClientUrlsInterface

    constructor(urls: ItemsApiClientUrlsInterface) {
        this.urls = urls
    }

    fetchItems(): Promise<ItemInterface[]> {
        // return new Promise<ItemInterface[]>((resolve) => {
        //     const url = this.urls.fetchItems
        //     const options: AxiosRequestConfig = {
        //         headers: {}
        //     }

        //     axios.get(url, options)
        //         .then((response: AxiosResponse) => {
        //             resolve(response.data as ItemInterface[])
        //         })
        //         .catch((error: any) => {
        //             console.error("ItemsApiClient:HttpClient: get: error", error)
        //         })
        // })
        
        const getParameters: HttpRequestParamsInterface = {
            url: this.urls.fetchItems,
            requiresToken: false
        }
        return HttpClient.get<ItemInterface[]>(getParameters)
    }
}