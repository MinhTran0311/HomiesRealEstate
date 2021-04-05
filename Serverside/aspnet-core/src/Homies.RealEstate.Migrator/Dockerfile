#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["src/Homies.RealEstate.Migrator/Homies.RealEstate.Migrator.csproj", "src/Homies.RealEstate.Migrator/"]
COPY ["src/Homies.RealEstate.EntityFrameworkCore/Homies.RealEstate.EntityFrameworkCore.csproj", "src/Homies.RealEstate.EntityFrameworkCore/"]
COPY ["src/Homies.RealEstate.Core/Homies.RealEstate.Core.csproj", "src/Homies.RealEstate.Core/"]
COPY ["src/Homies.RealEstate.Core.Shared/Homies.RealEstate.Core.Shared.csproj", "src/Homies.RealEstate.Core.Shared/"]
RUN dotnet restore "src/Homies.RealEstate.Migrator/Homies.RealEstate.Migrator.csproj"
COPY . .
WORKDIR "/src/src/Homies.RealEstate.Migrator"
RUN dotnet build "Homies.RealEstate.Migrator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Homies.RealEstate.Migrator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Homies.RealEstate.Migrator.dll"]
