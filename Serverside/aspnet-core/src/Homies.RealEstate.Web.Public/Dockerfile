#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["src/Homies.RealEstate.Web.Public/Homies.RealEstate.Web.Public.csproj", "src/Homies.RealEstate.Web.Public/"]
COPY ["src/Homies.RealEstate.Web.Core/Homies.RealEstate.Web.Core.csproj", "src/Homies.RealEstate.Web.Core/"]
COPY ["src/Homies.RealEstate.Application/Homies.RealEstate.Application.csproj", "src/Homies.RealEstate.Application/"]
COPY ["src/Homies.RealEstate.Application.Shared/Homies.RealEstate.Application.Shared.csproj", "src/Homies.RealEstate.Application.Shared/"]
COPY ["src/Homies.RealEstate.Core.Shared/Homies.RealEstate.Core.Shared.csproj", "src/Homies.RealEstate.Core.Shared/"]
COPY ["src/Homies.RealEstate.Core/Homies.RealEstate.Core.csproj", "src/Homies.RealEstate.Core/"]
COPY ["src/Homies.RealEstate.EntityFrameworkCore/Homies.RealEstate.EntityFrameworkCore.csproj", "src/Homies.RealEstate.EntityFrameworkCore/"]
COPY ["src/Homies.RealEstate.GraphQL/Homies.RealEstate.GraphQL.csproj", "src/Homies.RealEstate.GraphQL/"]
RUN dotnet restore "src/Homies.RealEstate.Web.Public/Homies.RealEstate.Web.Public.csproj"
COPY . .
WORKDIR "/src/src/Homies.RealEstate.Web.Public"
RUN dotnet build "Homies.RealEstate.Web.Public.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Homies.RealEstate.Web.Public.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Homies.RealEstate.Web.Public.dll"]
