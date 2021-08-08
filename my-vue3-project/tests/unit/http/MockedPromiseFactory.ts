import axios, { AxiosRequestConfig, AxiosResponse } from "axios"
export interface MockedPromiseFactoryParamsInterface {
    url: string
    requestConfig: AxiosRequestConfig
    statusCode: number
    statusText: string
    data: any
    reject: boolean
}

export const MockedPromiseFactory = (parmas: MockedPromiseFactoryParamsInterface): Promise<AxiosResponse<string>> =>{
    return new Promise<AxiosResponse<string>>((resolve, reject)=>{
        setTimeout(() => {
           const response:  AxiosResponse = {
               data: parmas.data,
               status: parmas.statusCode,
               statusText: parmas.statusText,
               headers: [],
               config: parmas.requestConfig
           }

           if(parmas.reject){
               reject(response)
           }else{
               resolve(response)
           }
        }, 100);
    })
}