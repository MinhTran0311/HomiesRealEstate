import { Renderer2 } from '@angular/core';
import { GridsterComponentInterface } from './gridster.interface';
import { GridsterItem } from './gridsterItem.interface';
export declare class GridsterRenderer {
    private gridster;
    constructor(gridster: GridsterComponentInterface);
    destroy(): void;
    updateItem(el: Element, item: GridsterItem, renderer: Renderer2): void;
    updateGridster(): void;
    getGridColumnStyle(i: number): {
        [key: string]: string;
    };
    getGridRowStyle(i: number): {
        [key: string]: string;
    };
    getLeftPosition(d: number): {
        left: string;
    } | {
        transform: string;
    };
    getTopPosition(d: number): {
        top: string;
    } | {
        transform: string;
    };
    clearCellPosition(renderer: Renderer2, el: Element): void;
    setCellPosition(renderer: Renderer2, el: Element, x: number, y: number): void;
    getLeftMargin(): number;
    getTopMargin(): number;
}
